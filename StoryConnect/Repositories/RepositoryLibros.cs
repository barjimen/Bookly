
using StoryConnect.Context;
using StoryConnect.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;
using StoryConnect.Helper;

namespace StoryConnect.Repositories
{
    public class RepositoryLibros : IRepositoryLibros
    {
        private StoryContext context;

        public RepositoryLibros(StoryContext context)
        {
            this.context = context;
        }
        public Task AddAsync(Libros libros)
        {
            throw new NotImplementedException();
        }

        public Task DeleteAsync(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<Libros> FindLibros(int id)
        {
            var consulta = from datos in context.Libros
                           where datos.Id == id
                           select datos;
            return consulta.FirstOrDefault();
        }
        public async Task<List<Etiquetas>> ObtenerEtiquetasLibro(int libroId)
        {
            var etiquetas = await this.context.LibrosEtiquetas
                .Where(le => le.LibroId == libroId)
                .Include(le => le.Etiqueta)
                .Select(le => le.Etiqueta)
                .ToListAsync();
            return etiquetas;
        }

        public async Task<List<Libros>> GetLibrosAsync()
        {
            var consulta = from datos in context.Libros
                           select datos;
            return consulta.AsNoTracking().ToList();
        }

        public Task UpdateAsync(Libros libros)
        {
            throw new NotImplementedException();
        }


        public async Task<List<Libros>> BuscarLibrosAsync(string query)
        {
            return await this.context.Libros
                .Where(l => l.Titulo.Contains(query) || l.NombreAutor.Contains(query)) 
                .Take(5) // Máximo 5 resultados
                .ToListAsync();
        }

        public async Task<List<LibrosLeyendo>> LibrosLeyendo(int idUsuario)
        {
            var consulta = await this.context.LibrosLeyendo
                             .Where(datos => datos.IdUsuario == idUsuario)
                             .AsNoTracking() // Evita que EF haga caché de los resultados
                             .ToListAsync();
            return consulta;
        }


    public async Task MoverLibrosLista(int idUsuario, int idLibro, int origen, int destino)
    {
        string sql = "EXEC sp_MoverLibroEntreListas @UsuarioID, @LibroID, @ListaOrigenID, @ListaDestinoID";

        SqlParameter pamidUsuario = new SqlParameter("@UsuarioID", idUsuario);
        SqlParameter pamidLibro = new SqlParameter("@LibroID", idLibro);
        SqlParameter pamOrigen = new SqlParameter("@ListaOrigenID", origen);
        SqlParameter pamDestino = new SqlParameter("@ListaDestinoID", destino);

          await this.context.Database.ExecuteSqlRawAsync(sql, pamidUsuario, pamidLibro, pamOrigen, pamDestino);
        }

        public async Task<List<Autores>> GetAutoresAsync()
        {
            var consulta = from datos in context.Autores
                           select datos;
            return consulta.ToList();
        }

        public async Task<Usuarios> Login(string email, string password)
        {
            var consulta = from datos in context.Usuarios
                           where datos.email == email
                           select datos;
            Usuarios usuario = await consulta.FirstOrDefaultAsync();
            if (usuario == null)
            {
                return null;
            }
            else
            {
                
               string salt = usuario.Salt;
               byte[] pass_temp = HelperCryptography.EncryptPassword(password, salt);
               byte[] pass_encrypt = usuario.Password_hash;
               bool resultado = HelperCryptography.CompararArrays(pass_temp, pass_encrypt);
                if (resultado == true)
                {
                    return usuario;

                }
                else
                {
                    return null;
                }
            }
        }

        public async Task Register(string nombre, string email, string password)
        {
            Usuarios usuario = new Usuarios();
            int nuevoId = (context.Usuarios.Max(u => (int?)u.Id) ?? 0) + 1;
            usuario.Id = nuevoId;
            usuario.Nombre = nombre;
            usuario.email = email;
            usuario.Password = password;
            usuario.Salt = HelperCryptography.GenerateSalt();
            usuario.Password_hash = HelperCryptography.EncryptPassword(password, usuario.Salt);
            usuario.ImagenPerfil = "default.jpg";
            usuario.FechaRegistro = DateTime.Now;
            usuario.TipoUsuario = "lector";

            this.context.Usuarios.Add(usuario);
            await context.SaveChangesAsync();
        }


        public async Task<Usuarios> GetUsuario(int id)
        {
            var usuario = await this.context.Usuarios.Where(x => x.Id == id).FirstOrDefaultAsync();
            return usuario;
        }

        public async Task<List<CountLibrosListasPredefinidas>> ObtenerCountListas(int idUsuario)
        {
            var consulta = await this.context.CountLibrosListasPredefinidas
                               .Where(datos => datos.Id == idUsuario)
                               .AsNoTracking()
                               .ToListAsync();
            return consulta;
        }

        public async Task<List<LibrosListasPredefinidas>> LibrosEnPredefinidos(int idUsuario)
        {
            var consulta = await this.context.LibrosListasPredefinidas
                           .Where(datos => datos.Id == idUsuario)
                           .AsNoTracking()
                           .ToListAsync();
            return consulta;
        }

        public async Task<List<LibrosListasPredefinidas>> FindLibrosEnPredefinidos(int idUsuario, int idlista)
        {
            var consulta = await this.context.LibrosListasPredefinidas
                           .Where(datos => datos.Id == idUsuario && datos.ListaId == idlista)
                           .AsNoTracking()
                           .ToListAsync();
            return consulta;
        }

        public async Task<List<ObjetivosUsuarios>> ObjetivosUsuarios(int idUsuario)
        {
            var consulta = await this.context.ObjetivosUsuarios
                .Where(datos => datos.IdUsuario == idUsuario)
                .AsNoTracking()
                .ToListAsync();
            return consulta;
        }
    }
}

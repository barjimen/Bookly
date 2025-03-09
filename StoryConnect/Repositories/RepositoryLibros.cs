
using StoryConnect.Context;
using StoryConnect.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;

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

        public async Task<List<Libros>> GetLibrosAsync()
        {
            var consulta = from datos in context.Libros
                           select datos;
            return consulta.ToList();
        }

        public Task UpdateAsync(Libros libros)
        {
            throw new NotImplementedException();
        }


        public async Task<List<Libros>> BuscarLibrosAsync(string query)
        {
            return await this.context.Libros
                .Where(l => l.Titulo.Contains(query)) // Filtra por título
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


}
}

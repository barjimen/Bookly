using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StoryConnect.Context;
using StoryConnect.Helper;
using StoryConnect.Models;

namespace StoryConnect.Repositories
{
    public class UserRepository
    {
        private StoryContext context;
        public UserRepository(StoryContext context)
        {
            this.context = context;
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
            usuario.Nombre = nombre;
            usuario.email = email;
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
    }
}

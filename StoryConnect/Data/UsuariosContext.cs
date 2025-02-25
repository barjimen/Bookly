using Microsoft.EntityFrameworkCore;
using StoryConnect.Models;

namespace StoryConnect.Data
{
    public class UsuariosContext : DbContext
    {
        public UsuariosContext(DbContextOptions<UsuariosContext> options) : base(options)
        {
        }
        public DbSet<Usuarios> Usuarios { get; set; }
    }
}

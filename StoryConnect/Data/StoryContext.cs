using Microsoft.EntityFrameworkCore;
using StoryConnect.Models;

namespace StoryConnect.Context
{
    public class StoryContext : DbContext
    {
        public StoryContext(DbContextOptions<StoryContext> options) : base(options) { }

        public DbSet<Libros> Libros { get; set; }
        public DbSet<Autores> Autores { get; set; }
    }
}

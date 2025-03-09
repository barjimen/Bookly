﻿using Microsoft.EntityFrameworkCore;
using StoryConnect.Models;

namespace StoryConnect.Context
{
    public class StoryContext : DbContext
    {
        public StoryContext(DbContextOptions<StoryContext> options) : base(options) { }

        public DbSet<Libros> Libros { get; set; }
        public DbSet<Autores> Autores { get; set; }
        public DbSet<Usuarios> Usuarios { get; set; }
        public DbSet<LibrosLeyendo> LibrosLeyendo { get; set; }
        public DbSet<ObjetivosUsuarios> ObjetivosUsuarios { get; set; }
        public DbSet<LibrosListasPredefinidas> LibrosListasPredefinidas { get; set; }
        public DbSet<CountLibrosListasPredefinidas> CountLibrosListasPredefinidas{ get; set; }
    }
}

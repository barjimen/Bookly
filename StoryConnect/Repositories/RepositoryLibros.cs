
using StoryConnect.Context;
using StoryConnect.Models;
using Microsoft.EntityFrameworkCore;

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


    }
}

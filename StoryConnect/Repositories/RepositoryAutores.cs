using StoryConnect.Context;
using StoryConnect.Models;

namespace StoryConnect.Repositories
{
    public class RepositoryAutores
    {
        private StoryContext context;

        public RepositoryAutores(StoryContext context)
        {
            this.context = context;
        }
        public async Task<List<Autores>> GetAutoresAsync()
        {
            var consulta = from datos in context.Autores
                        select datos;
            return consulta.ToList();
        }
    }
}

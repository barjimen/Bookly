using StoryConnect.Models;

namespace StoryConnect.Repositories
{
    public interface IRepositoryLibros
    {
        Task<List<Libros>> GetLibrosAsync();
        Task<Libros> FindLibros(int id);
        Task AddAsync(Libros libros);
        Task DeleteAsync(int id);
        Task UpdateAsync(Libros libros);

        Task<List<Libros>> BuscarLibrosAsync(string query);

        Task<List<LibrosLeyendo>> LibrosLeyendo(int idUsuario);

        Task MoverLibrosLista(int idUsuario, int idLibro, int origen, int destino);

    }
}

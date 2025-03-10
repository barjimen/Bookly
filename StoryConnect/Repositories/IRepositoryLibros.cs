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
        Task<List<Etiquetas>> ObtenerEtiquetasLibro(int libroId);
        Task MoverLibrosLista(int idUsuario, int idLibro, int origen, int destino);
        Task<List<Autores>> GetAutoresAsync();
        Task<Usuarios> Login(string email, string password);
        Task Register(string nombre, string email, string password);
        Task<Usuarios> GetUsuario(int id);
        Task<List<CountLibrosListasPredefinidas>> ObtenerCountListas(int idUsuario);
        Task<List<LibrosListasPredefinidas>> LibrosEnPredefinidos(int idUsuario);
        Task<List<ObjetivosUsuarios>> ObjetivosUsuarios(int idUsuario);
        Task<List<LibrosListasPredefinidas>> FindLibrosEnPredefinidos(int idUsuario, int idlista);
    }
}

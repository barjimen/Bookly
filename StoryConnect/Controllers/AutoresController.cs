using Microsoft.AspNetCore.Mvc;
using StoryConnect.Models;
using StoryConnect.Repositories;

namespace StoryConnect.Controllers
{
    public class AutoresController : Controller
    {
        private IRepositoryLibros repo;
        public AutoresController(IRepositoryLibros repo)
        {
            this.repo = repo;
        }
        public async Task<IActionResult> Index()
        {
            List<Autores> autores =
                await this.repo.GetAutoresAsync();
            return View(autores);
        }

        

    }
}

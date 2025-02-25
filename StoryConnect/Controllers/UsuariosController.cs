using System.Data.Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StoryConnect.Data;
using StoryConnect.Models;
using System.Security.Cryptography;

namespace StoryConnect.Controllers
{
    public class UsuariosController : Controller
    {
        private UsuariosContext context;
        public UsuariosController(UsuariosContext context)
        {
            this.context = context;
        }
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Register(string nombre, string email, byte[] password)
        {
            Usuarios usuario = new Usuarios
            {
                Nombre = nombre,
                email = email,
                Password = password,
                ImagenPerfil = "default.jpg",
                FechaRegistro = DateTime.Now,
                TipoUsuario = "lector"
            };
            this.context.Usuarios.Add(usuario);
            await context.SaveChangesAsync();
            ViewData["Mensaje"] = "Usuario registrado correctamente.";
            return RedirectToAction("Index", "Home");
        }

        public IActionResult Login()
        {
            return View();
        }


        [HttpPost]
        public async Task<IActionResult> Login(string email, byte[] password)
        {
            Usuarios usuario = await this.context.Usuarios.FirstOrDefaultAsync(u => u.email == email && u.Password == password);
            if (usuario == null)
            {
                ViewData["Error"] = "Email o contraseña incorrectos.";
            }
            else
            {
                HttpContext.Session.SetInt32("id", usuario.Id);
                HttpContext.Session.SetString("email", usuario.email);
                HttpContext.Session.SetString("nombre", usuario.Nombre);
                HttpContext.Session.SetString("tipo", usuario.TipoUsuario);
                HttpContext.Session.SetString("imagen", usuario.ImagenPerfil);
            }
            return RedirectToAction("Index", "Home");
        }


        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }


        public IActionResult Index()
        {
            return View();
        }
    }
}

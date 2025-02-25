using System.Configuration;
using Microsoft.EntityFrameworkCore;
using StoryConnect.Context;
using StoryConnect.Data;
using StoryConnect.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
//string connectionString = builder.Configuration.GetConnectionString("StorySQL");
builder.Services.AddDbContext<UsuariosContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("StorySQL")));
builder.Services.AddDbContext<StoryContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("StorySQL")));
builder.Services.AddTransient<IRepositoryLibros, RepositoryLibros>();
builder.Services.AddTransient<RepositoryAutores>();
builder.Services.AddSession();
builder.Services.AddHttpContextAccessor();
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseSession();

app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();


app.Run();

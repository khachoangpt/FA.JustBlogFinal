using FA.JustBlog.Models.Common;
using System.Data.Entity;

namespace FA.JustBlog.Data
{
    public class JustBlogContext : DbContext
    {
        public JustBlogContext() : base("JustBlogConn")
        {
            Database.SetInitializer(new JustBlogInitializer());
        }

        static JustBlogContext()
        {
            // Set the database initializer which is run once during application start
            // This seeds the database with admin user credentials and admin role
            Database.SetInitializer<JustBlogContext>(new JustBlogInitializer());
        }

        public static JustBlogContext Create()
        {
            return new JustBlogContext();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>()
                .HasMany(p => p.Tags)
                .WithMany(t => t.Posts)
                .Map(m =>
                {
                    m.MapLeftKey("PostId");
                    m.MapRightKey("TagId");
                    m.ToTable("PostTagMap");
                });
        }

        public DbSet<Category> Categories { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<Comment> Comments { get; set; }
    }
}

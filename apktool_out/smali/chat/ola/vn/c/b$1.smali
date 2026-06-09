.class Lchat/ola/vn/c/b$1;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/b;->a(Lchat/ola/vn/c/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/a;

.field final synthetic b:Lchat/ola/vn/c/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/b;Lchat/ola/vn/c/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/b$1;->b:Lchat/ola/vn/c/b;

    iput-object p2, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/c/b$1;->b:Lchat/ola/vn/c/b;

    iget-object p1, p1, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    if-eqz p1, :cond_2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    iget-boolean p1, p1, Lchat/ola/vn/c/a;->d:Z

    if-eqz p1, :cond_1

    new-instance p1, Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/c/b$1;->b:Lchat/ola/vn/c/b;

    iget-object v0, v0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    const-string v1, ".best"

    invoke-direct {p1, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->mkdir()Z

    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    iget-object v1, v1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    invoke-direct {v0, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    iget-object p1, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-static {p1, v0}, Lcom/mg/ola/common/d/c;->b(Landroid/graphics/Bitmap;Ljava/io/File;)V

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/c/b$1;->b:Lchat/ola/vn/c/b;

    iget-object v0, v0, Lchat/ola/vn/c/b;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    iget-object v1, v1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    invoke-direct {p1, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/c/b$1;->a:Lchat/ola/vn/c/a;

    iget-object v0, v0, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-static {v0, p1}, Lcom/mg/ola/common/d/c;->b(Landroid/graphics/Bitmap;Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/b$1;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method

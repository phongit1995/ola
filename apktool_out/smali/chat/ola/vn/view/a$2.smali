.class Lchat/ola/vn/view/a$2;
.super Lchat/ola/vn/c/i;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/a;->b(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/view/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/a$2;->b:Lchat/ola/vn/view/a;

    iput-object p2, p0, Lchat/ola/vn/view/a$2;->a:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/c/i;-><init>()V

    return-void
.end method


# virtual methods
.method public c(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/view/a$2;->a:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/view/a$2;->b:Lchat/ola/vn/view/a;

    invoke-static {v0}, Lchat/ola/vn/view/a;->a(Lchat/ola/vn/view/a;)I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/a$2;->b:Lchat/ola/vn/view/a;

    invoke-static {v1}, Lchat/ola/vn/view/a;->b(Lchat/ola/vn/view/a;)I

    move-result v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;II)Lchat/ola/vn/c/f;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/view/a$2$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/a$2$1;-><init>(Lchat/ola/vn/view/a$2;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    new-instance v0, Lchat/ola/vn/c/e;

    invoke-direct {v0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v1, 0x1

    new-array v1, v1, [Lchat/ola/vn/c/f;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;Landroid/graphics/Bitmap;)V
    .locals 0

    new-instance p1, Lchat/ola/vn/view/a$2$2;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/view/a$2$2;-><init>(Lchat/ola/vn/view/a$2;Landroid/graphics/Bitmap;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

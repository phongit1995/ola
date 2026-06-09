.class public Lchat/ola/vn/h/c;
.super Lchat/ola/vn/entity/ah;


# instance fields
.field private a:Landroid/graphics/Bitmap;


# direct methods
.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/entity/ah;-><init>(I)V

    return-void
.end method

.method public static a(Lchat/ola/vn/entity/ah;)Lchat/ola/vn/h/c;
    .locals 2

    new-instance v0, Lchat/ola/vn/h/c;

    invoke-virtual {p0}, Lchat/ola/vn/entity/ah;->b()I

    move-result v1

    invoke-direct {v0, v1}, Lchat/ola/vn/h/c;-><init>(I)V

    invoke-virtual {p0}, Lchat/ola/vn/entity/ah;->f()Z

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/h/c;->a(Z)V

    invoke-virtual {p0}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/h/c;->b(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lchat/ola/vn/h/c;->a(Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public a()Landroid/graphics/Bitmap;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/h/c;->a:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public a(Landroid/graphics/Bitmap;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/c;->a:Landroid/graphics/Bitmap;

    return-void
.end method

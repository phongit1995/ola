.class Lchat/ola/vn/i/s$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/s;->a(Ljava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/i/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/s;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    iput-object p2, p0, Lchat/ola/vn/i/s$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/i/s$1$1;

    invoke-direct {v1, p0, p1, p2}, Lchat/ola/vn/i/s$1$1;-><init>(Lchat/ola/vn/i/s$1;II)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/i/s$1$2;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/i/s$1$2;-><init>(Lchat/ola/vn/i/s$1;Lchat/ola/vn/entity/i;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/i/s$1$3;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/i/s$1$3;-><init>(Lchat/ola/vn/i/s$1;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    iget-object p2, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {p2}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/i/s$1$6;

    invoke-direct {p3, p0, p1}, Lchat/ola/vn/i/s$1$6;-><init>(Lchat/ola/vn/i/s$1;Ljava/lang/String;)V

    invoke-virtual {p2, p3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object p2, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {p2}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object p2

    new-instance v0, Lchat/ola/vn/i/s$1$5;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/i/s$1$5;-><init>(Lchat/ola/vn/i/s$1;Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object p2, p0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {p2}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;)Landroid/os/Handler;

    move-result-object p2

    new-instance v0, Lchat/ola/vn/i/s$1$4;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/i/s$1$4;-><init>(Lchat/ola/vn/i/s$1;Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.class Lchat/ola/vn/u/m$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/p;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/u/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/m;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    invoke-static {}, Lchat/ola/vn/u/d;->d()Lchat/ola/vn/u/d;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->a:Lchat/ola/vn/u/d;

    iget-object v1, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    invoke-virtual {v0, v1}, Lchat/ola/vn/u/d;->a(Lchat/ola/vn/u/g;)V

    iget-object v2, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget v3, v0, Lchat/ola/vn/u/m;->h:I

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v4, v0, Lchat/ola/vn/u/m;->e:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget v5, v0, Lchat/ola/vn/u/m;->g:I

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->d()Ljava/lang/String;

    move-result-object v6

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v7, v0, Lchat/ola/vn/u/m;->c:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    iget-boolean v8, v0, Lchat/ola/vn/u/p;->b:Z

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    iget-object v0, v0, Lchat/ola/vn/u/m;->d:Lchat/ola/vn/u/p;

    invoke-virtual {v0}, Lchat/ola/vn/u/p;->e()Ljava/lang/String;

    move-result-object v9

    invoke-static/range {v2 .. v9}, Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/m;ILjava/lang/String;ILjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    iget-object v0, p0, Lchat/ola/vn/u/m$1;->a:Lchat/ola/vn/u/m;

    invoke-static {v0}, Lchat/ola/vn/u/m;->a(Lchat/ola/vn/u/m;)V

    return-void
.end method

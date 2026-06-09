.class Lchat/ola/vn/i/s$1$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/s$1;->a(Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/i;

.field final synthetic b:Lchat/ola/vn/i/s$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/s$1;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iput-object p2, p0, Lchat/ola/vn/i/s$1$2;->a:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->a:Lchat/ola/vn/entity/i;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->b(Lchat/ola/vn/i/s;)Lchat/ola/vn/i/s$a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->b(Lchat/ola/vn/i/s;)Lchat/ola/vn/i/s$a;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/s$1$2;->a:Lchat/ola/vn/entity/i;

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lchat/ola/vn/i/s$a;->f(Ljava/lang/String;)V

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v1, v1, Lchat/ola/vn/i/s$1;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/i/s$1$2;->a:Lchat/ola/vn/entity/i;

    invoke-virtual {v2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->c(Lchat/ola/vn/i/s;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->c(Lchat/ola/vn/i/s;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v1, v1, Lchat/ola/vn/i/s$1;->a:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-static {v0}, Lchat/ola/vn/i/s;->c(Lchat/ola/vn/i/s;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/i/s$1$2;->b:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    invoke-virtual {v0}, Lchat/ola/vn/i/s;->dismiss()V

    :cond_2
    return-void
.end method

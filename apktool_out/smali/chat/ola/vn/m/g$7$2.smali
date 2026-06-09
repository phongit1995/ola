.class Lchat/ola/vn/m/g$7$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/g$7;->a(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/m/g$7;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/g$7;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iput-object p2, p0, Lchat/ola/vn/m/g$7$2;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/m/g$7$2;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->b:Lchat/ola/vn/p/b;

    iget-object v1, p0, Lchat/ola/vn/m/g$7$2;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/m/g$7$2;->b:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lchat/ola/vn/p/b;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-static {v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/m/g;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/g$7$2;->c:Lchat/ola/vn/m/g$7;

    iget-object v0, v0, Lchat/ola/vn/m/g$7;->c:Lchat/ola/vn/m/g;

    invoke-virtual {v0}, Lchat/ola/vn/m/g;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

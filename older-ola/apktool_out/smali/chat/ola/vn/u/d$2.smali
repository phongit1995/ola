.class Lchat/ola/vn/u/d$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/u/d;->b(Lchat/ola/vn/u/e;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/u/e;

.field final synthetic b:Lchat/ola/vn/u/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/u/d;Lchat/ola/vn/u/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/u/d$2;->b:Lchat/ola/vn/u/d;

    iput-object p2, p0, Lchat/ola/vn/u/d$2;->a:Lchat/ola/vn/u/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/u/d$2;->a:Lchat/ola/vn/u/e;

    iget-short v0, v0, Lchat/ola/vn/u/e;->j:S

    invoke-static {v0}, Lchat/ola/vn/u/k;->a(S)Lchat/ola/vn/u/a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/u/d$2;->a:Lchat/ola/vn/u/e;

    iget-object v2, p0, Lchat/ola/vn/u/d$2;->b:Lchat/ola/vn/u/d;

    invoke-static {v2}, Lchat/ola/vn/u/d;->a(Lchat/ola/vn/u/d;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lchat/ola/vn/u/a;->a(Lchat/ola/vn/u/e;Ljava/util/List;)Lchat/ola/vn/w/cg;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/u/d$2;->b:Lchat/ola/vn/u/d;

    iget-object v1, v1, Lchat/ola/vn/u/d;->b:Lchat/ola/vn/u/n;

    invoke-virtual {v1, v0}, Lchat/ola/vn/u/n;->a(Lchat/ola/vn/w/cg;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/u/d$2;->b:Lchat/ola/vn/u/d;

    invoke-virtual {v0}, Lchat/ola/vn/u/d;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/u/d$2;->b:Lchat/ola/vn/u/d;

    invoke-virtual {v0}, Lchat/ola/vn/u/d;->b()V

    return-void
.end method

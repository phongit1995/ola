.class final Lchat/ola/vn/r/a/e$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entity/q;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/q;


# direct methods
.method constructor <init>(Lchat/ola/vn/entity/q;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/r/a/e;->A()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    iget-object v1, v1, Lchat/ola/vn/entity/q;->c:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    iget v1, v1, Lchat/ola/vn/entity/q;->d:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/g;->a(I)V

    iget-object v1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    iget v1, v1, Lchat/ola/vn/entity/q;->e:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/g;->c(I)V

    iget-object v1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    iget-short v1, v1, Lchat/ola/vn/entity/q;->f:S

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object v1, p0, Lchat/ola/vn/r/a/e$2;->a:Lchat/ola/vn/entity/q;

    iget-object v1, v1, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

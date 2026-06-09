.class Lchat/ola/vn/r/a/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/r/a/e;->e()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/r/a/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/r/a/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    const/4 v0, -0x1

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->e(I)I

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->f(I)I

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/e;Ljava/util/List;)Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    new-instance v1, Ljava/util/Stack;

    invoke-direct {v1}, Ljava/util/Stack;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Ljava/util/Stack;)Ljava/util/Stack;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Lchat/ola/vn/entity/g;)Lchat/ola/vn/entity/g;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;S)S

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0, v2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Z)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    iput-boolean v2, v0, Lchat/ola/vn/r/a/e;->g:Z

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0, v2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;I)I

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/e;I)I

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0, v1}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/e;Lchat/ola/vn/me/a;)Lchat/ola/vn/me/a;

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/e;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    invoke-interface {v1}, Lchat/ola/vn/r/a/d;->E()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/e;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/a/e$1;->a:Lchat/ola/vn/r/a/e;

    invoke-static {v0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/e;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_1
    return-void
.end method

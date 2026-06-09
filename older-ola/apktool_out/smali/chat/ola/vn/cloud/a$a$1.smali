.class Lchat/ola/vn/cloud/a$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/a$a;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/a$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/a$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    invoke-static {p1}, Lchat/ola/vn/cloud/a;->a(Lchat/ola/vn/cloud/a;)B

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-static {p1}, Lchat/ola/vn/cloud/a$a;->a(Lchat/ola/vn/cloud/a$a;)Lchat/ola/vn/entity/l;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/l;->a()Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    invoke-static {p1}, Lchat/ola/vn/cloud/a;->b(Lchat/ola/vn/cloud/a;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-static {p1}, Lchat/ola/vn/cloud/a$a;->a(Lchat/ola/vn/cloud/a$a;)Lchat/ola/vn/entity/l;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-static {v1}, Lchat/ola/vn/cloud/a$a;->a(Lchat/ola/vn/cloud/a$a;)Lchat/ola/vn/entity/l;

    move-result-object v1

    iget-boolean v1, v1, Lchat/ola/vn/entity/l;->k:Z

    xor-int/2addr v0, v1

    iput-boolean v0, p1, Lchat/ola/vn/entity/l;->k:Z

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-static {p1}, Lchat/ola/vn/cloud/a$a;->b(Lchat/ola/vn/cloud/a$a;)V

    const/4 p1, 0x0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    invoke-static {v0}, Lchat/ola/vn/cloud/a;->c(Lchat/ola/vn/cloud/a;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/l;

    iget-boolean v1, v1, Lchat/ola/vn/entity/l;->k:Z

    if-eqz v1, :cond_0

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    iget-object v0, v0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    iget-object v0, v0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    invoke-interface {v0, p1}, Lchat/ola/vn/cloud/d;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    iget-object p1, p1, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a$1;->a:Lchat/ola/vn/cloud/a$a;

    invoke-static {v0}, Lchat/ola/vn/cloud/a$a;->a(Lchat/ola/vn/cloud/a$a;)Lchat/ola/vn/entity/l;

    move-result-object v0

    invoke-interface {p1, v0}, Lchat/ola/vn/cloud/d;->a(Lchat/ola/vn/entity/l;)V

    :catch_0
    :cond_3
    return-void
.end method

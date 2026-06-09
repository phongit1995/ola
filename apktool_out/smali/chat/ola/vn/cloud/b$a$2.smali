.class Lchat/ola/vn/cloud/b$a$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/b$a;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/b$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/b$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 3

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {p1}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->b()Z

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p1, v1}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/b;Ljava/util/List;)Ljava/util/List;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v1}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v1

    invoke-interface {p1, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v1}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v1

    invoke-interface {p1, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v2, v2, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v2}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/i;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/i;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {p1}, Lchat/ola/vn/cloud/b$a;->b(Lchat/ola/vn/cloud/b$a;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->e()V

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object p1, p1, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$2;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object p1, p1, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    invoke-interface {p1, v0}, Lchat/ola/vn/cloud/d;->d(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_3
    const/4 p1, 0x1

    return p1
.end method

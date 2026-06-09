.class Lchat/ola/vn/cloud/b$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


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

    iput-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/b;)B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_5

    const/4 p1, 0x0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object v0, v0, Lchat/ola/vn/cloud/b;->a:Landroid/view/LayoutInflater;

    invoke-virtual {v0}, Landroid/view/LayoutInflater;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f010055

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v0}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->b()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v2}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v2}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v0}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v0

    const/4 v2, -0x1

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/i;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v3, v3, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v3}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-virtual {v3, v2}, Lchat/ola/vn/entity/i;->a(I)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v2}, Lchat/ola/vn/cloud/b;->a(Lchat/ola/vn/cloud/b;Ljava/util/List;)Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v2}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v2}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v0}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v0, :cond_2

    iget-object v3, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v3, v3, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {v3}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-virtual {v3, v2}, Lchat/ola/vn/entity/i;->a(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :catch_1
    :cond_2
    if-eqz p1, :cond_3

    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->a:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_3
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    invoke-static {p1}, Lchat/ola/vn/cloud/b;->b(Lchat/ola/vn/cloud/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object p1, p1, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object p1, p1, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object p1, p1, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    invoke-interface {p1, v1}, Lchat/ola/vn/cloud/d;->d(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object v0, v0, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    iget-object v0, v0, Lchat/ola/vn/cloud/b$a;->d:Lchat/ola/vn/cloud/b;

    iget-object v0, v0, Lchat/ola/vn/cloud/b;->b:Lchat/ola/vn/cloud/d;

    iget-object v1, p0, Lchat/ola/vn/cloud/b$a$1;->a:Lchat/ola/vn/cloud/b$a;

    invoke-static {v1}, Lchat/ola/vn/cloud/b$a;->a(Lchat/ola/vn/cloud/b$a;)Lchat/ola/vn/entity/i;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/cloud/d;->a(Landroid/view/View;Lchat/ola/vn/entity/i;)V

    :catch_3
    :cond_6
    return-void
.end method

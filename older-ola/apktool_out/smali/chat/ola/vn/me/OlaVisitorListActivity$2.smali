.class Lchat/ola/vn/me/OlaVisitorListActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/k;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaVisitorListActivity;->D()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaVisitorListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaVisitorListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->d(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->f(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->g(Lchat/ola/vn/me/OlaVisitorListActivity;)V

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->d(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->f(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p2, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0, p2}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/lang/String;)Ljava/lang/String;

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;

    move-result-object p2

    if-nez p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p2, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/util/List;)Ljava/util/List;

    :cond_2
    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaVisitorListActivity;->h(Lchat/ola/vn/me/OlaVisitorListActivity;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaVisitorListActivity;->c(Lchat/ola/vn/me/OlaVisitorListActivity;)Lchat/ola/vn/me/d;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/me/d;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaVisitorListActivity;->c(Lchat/ola/vn/me/OlaVisitorListActivity;)Lchat/ola/vn/me/d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/me/d;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$2;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {p1, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    return-void
.end method

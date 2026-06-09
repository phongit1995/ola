.class Lchat/ola/vn/me/c$15;
.super Lchat/ola/vn/entry/c/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->a(Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic c:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;Ljava/lang/String;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-direct {p0, p2, p3, p4}, Lchat/ola/vn/entry/c/c;-><init>(Ljava/lang/String;J)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/c;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Z)Z

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1, p2}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/me/c;Z)Z

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->e(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->c(Lchat/ola/vn/me/c;)Lchat/ola/vn/b/u;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/c;->a([Ljava/lang/Object;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/me/c;Z)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x2

    :try_start_1
    aget-object p1, p1, v0

    check-cast p1, Ljava/util/List;

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1, v1}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/me/c;Z)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c$15;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->e(Lchat/ola/vn/me/c;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_2
    return-void
.end method

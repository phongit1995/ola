.class Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x43

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    const/16 p2, 0x22

    if-ne p1, p2, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    const/4 p2, 0x0

    iput-object p2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    iput-object p2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->a(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->b(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    const/4 v0, 0x1

    const/16 v1, 0x8

    const/4 v2, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/String;

    const/4 v3, 0x2

    aget-object p1, p1, v3

    check-cast p1, [Ljava/lang/String;

    if-eqz p1, :cond_0

    array-length v3, p1

    if-lez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-virtual {v3, v0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->a(Ljava/lang/String;[Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    iput-object v2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    iput-object v2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->a(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->b(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    iput-object v2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    iput-object v2, p1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->a(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;->a:Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->b(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

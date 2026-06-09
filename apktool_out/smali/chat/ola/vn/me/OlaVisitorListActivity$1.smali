.class Lchat/ola/vn/me/OlaVisitorListActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaVisitorListActivity;->C()V
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

    iput-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    const/4 v2, 0x1

    invoke-static {v0, v2}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    :goto_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->c(Lchat/ola/vn/me/OlaVisitorListActivity;)Lchat/ola/vn/me/d;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v2}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/me/d;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->c(Lchat/ola/vn/me/OlaVisitorListActivity;)Lchat/ola/vn/me/d;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/me/d;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->b(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-virtual {v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a_(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->d(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity$1;->a:Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->e(Lchat/ola/vn/me/OlaVisitorListActivity;)V

    return-void
.end method

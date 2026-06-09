.class Lchat/ola/vn/m/k$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/k;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/k;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/k;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/k$1;->a:Lchat/ola/vn/m/k;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 2

    const-wide/16 v0, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/k;->a(J)J

    const-wide/16 v0, -0x1

    invoke-static {v0, v1}, Lchat/ola/vn/m/k;->b(J)J

    :try_start_0
    sget-object v0, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/m/k$1;->a:Lchat/ola/vn/m/k;

    invoke-static {v0}, Lchat/ola/vn/m/k;->a(Lchat/ola/vn/m/k;)Lchat/ola/vn/b/x;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/x;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/m/k$1;->a:Lchat/ola/vn/m/k;

    invoke-static {v0}, Lchat/ola/vn/m/k;->b(Lchat/ola/vn/m/k;)V

    iget-object v0, p0, Lchat/ola/vn/m/k$1;->a:Lchat/ola/vn/m/k;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/m/k;->a(Lchat/ola/vn/m/k;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/k$1;->a:Lchat/ola/vn/m/k;

    invoke-static {v0}, Lchat/ola/vn/m/k;->c(Lchat/ola/vn/m/k;)V

    return-void
.end method

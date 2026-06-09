.class Lchat/ola/vn/me/c$18;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->g(Lchat/ola/vn/me/c;)Ljava/lang/Runnable;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    new-instance v1, Lchat/ola/vn/me/c$18$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$18$1;-><init>(Lchat/ola/vn/me/c$18;)V

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-virtual {v0}, Lchat/ola/vn/me/c;->d()V

    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->j(Lchat/ola/vn/me/c;)V

    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->g(Lchat/ola/vn/me/c;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lchat/ola/vn/me/c$18;->a:Lchat/ola/vn/me/c;

    invoke-static {v0}, Lchat/ola/vn/me/c;->g(Lchat/ola/vn/me/c;)Ljava/lang/Runnable;

    move-result-object v0

    const-wide/16 v1, 0x7530

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void
.end method

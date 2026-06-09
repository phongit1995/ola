.class Lchat/ola/vn/me/OlaUserMePageActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity$1;->onRefresh()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaUserMePageActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$1$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$1$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity$1;

    iget-object v0, v0, Lchat/ola/vn/me/OlaUserMePageActivity$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->b(Lchat/ola/vn/me/OlaUserMePageActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$1$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity$1;

    iget-object v0, v0, Lchat/ola/vn/me/OlaUserMePageActivity$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$1$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity$1;

    iget-object v1, v1, Lchat/ola/vn/me/OlaUserMePageActivity$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->b(Lchat/ola/vn/me/OlaUserMePageActivity;)Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Lchat/ola/vn/me/OlaUserMePageActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$1$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity$1;

    iget-object v0, v0, Lchat/ola/vn/me/OlaUserMePageActivity$1;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Lchat/ola/vn/me/OlaUserMePageActivity;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_0
    return-void
.end method

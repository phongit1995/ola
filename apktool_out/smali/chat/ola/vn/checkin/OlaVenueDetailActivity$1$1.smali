.class Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;->onRefresh()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    iget-object v0, v0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->b(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    iget-object v0, v0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    iget-object v1, v1, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->b(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    iget-object v0, v0, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;->a:Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-static {v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Landroid/support/v4/widget/SwipeRefreshLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_0
    return-void
.end method

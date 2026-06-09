.class Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/checkin/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->c(Lchat/ola/vn/entity/OlaVenueEntity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;Z)V

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3, p4}, Lchat/ola/vn/checkin/b;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    invoke-virtual {p1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->finish()V

    return-void
.end method

.method public m_()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInCreateVenueItemActivity;Z)V

    return-void
.end method

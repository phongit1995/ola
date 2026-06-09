.class Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/checkin/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 1

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    const/4 v0, 0x0

    invoke-static {p2, v0}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Z)V

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->C()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v0

    invoke-interface {p2, p1, v0, p3, p4}, Lchat/ola/vn/checkin/b;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$7;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-virtual {p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->finish()V

    return-void
.end method

.method public m_()V
    .locals 0

    return-void
.end method

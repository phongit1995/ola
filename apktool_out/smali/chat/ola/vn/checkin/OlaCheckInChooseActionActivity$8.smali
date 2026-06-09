.class Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/OlaCheckInActionEntity;

.field final synthetic b:Lchat/ola/vn/entity/OlaCheckInItemEntity;

.field final synthetic c:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->c:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    iput-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->a:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iput-object p3, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->b:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object p1

    invoke-interface {p1}, Lchat/ola/vn/checkin/b;->m_()V

    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->c:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Z)V

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->B()Lchat/ola/vn/checkin/b;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->C()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->a:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->b:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-interface {v0, p1, v1, v2, v3}, Lchat/ola/vn/checkin/b;->a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$8;->c:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-virtual {p1}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->finish()V

    return-void
.end method

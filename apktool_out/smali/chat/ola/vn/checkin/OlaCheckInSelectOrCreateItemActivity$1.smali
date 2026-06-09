.class Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-static {p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Lchat/ola/vn/checkin/a;

    move-result-object p1

    invoke-virtual {p1, p3}, Lchat/ola/vn/checkin/a;->a(I)Lchat/ola/vn/entity/OlaCheckInItemEntity;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$1;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->C()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->D()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object p4

    invoke-static {p2, p3, p4, p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Ljava/lang/String;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    return-void
.end method

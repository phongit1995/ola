.class Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->D()V
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

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

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

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->b(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Lchat/ola/vn/b/c;

    move-result-object p2

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/c;->a(I)Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->a(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;)Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;

    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->d(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;)Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;->b(Lchat/ola/vn/checkin/OlaCheckInChooseActionActivity;Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.class Lchat/ola/vn/activity/OlaAppSettingActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAppSettingActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/activity/OlaAppSettingActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAppSettingActivity;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->c:Lchat/ola/vn/activity/OlaAppSettingActivity;

    iput p2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->a:I

    iput p3, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->c:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->a(Lchat/ola/vn/activity/OlaAppSettingActivity;)Lchat/ola/vn/b/b;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b/b;->getGroupCount()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->c:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaAppSettingActivity;->b(Lchat/ola/vn/activity/OlaAppSettingActivity;)Landroid/widget/ExpandableListView;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/widget/ExpandableListView;->expandGroup(I)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->a:I

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->c:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->b(Lchat/ola/vn/activity/OlaAppSettingActivity;)Landroid/widget/ExpandableListView;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->b:I

    iget v2, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->a:I

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ExpandableListView;->setSelectedChild(IIZ)Z

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->c:Lchat/ola/vn/activity/OlaAppSettingActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAppSettingActivity;->b(Lchat/ola/vn/activity/OlaAppSettingActivity;)Landroid/widget/ExpandableListView;

    move-result-object v0

    iget v1, p0, Lchat/ola/vn/activity/OlaAppSettingActivity$2;->b:I

    invoke-virtual {v0, v1}, Landroid/widget/ExpandableListView;->setSelectedGroup(I)V

    return-void
.end method

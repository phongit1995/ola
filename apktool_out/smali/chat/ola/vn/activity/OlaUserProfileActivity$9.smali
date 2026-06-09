.class Lchat/ola/vn/activity/OlaUserProfileActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaUserProfileActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$9;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$9;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->j(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/ScrollView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$9;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->c(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getBottom()I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Landroid/widget/ScrollView;->scrollTo(II)V

    return-void
.end method

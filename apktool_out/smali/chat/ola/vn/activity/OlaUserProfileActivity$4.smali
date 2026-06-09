.class Lchat/ola/vn/activity/OlaUserProfileActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaFacebookActivity$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->onClick(Landroid/view/View;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$4;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->getToken()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$4;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->d(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/network/c;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/l/b;->a(Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void
.end method

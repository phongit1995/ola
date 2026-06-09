.class Lchat/ola/vn/activity/OlaUserProfileActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->E()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$6;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$6;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->g(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method

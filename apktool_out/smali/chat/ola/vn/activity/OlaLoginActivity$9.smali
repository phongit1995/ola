.class Lchat/ola/vn/activity/OlaLoginActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/a/a/ai$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->J()Lchat/ola/vn/network/a/a/ai$a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a_(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    :try_start_0
    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    sput-boolean v0, Lchat/ola/vn/tutorial/OlaTutorialActivity;->f:Z

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->g:Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c_()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$9;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v3, 0x7f0f009f

    const v4, 0x7f0f025b

    const v5, 0x7f0f002c

    const v6, 0x7f0f0480

    new-instance v7, Lchat/ola/vn/activity/OlaLoginActivity$9$1;

    invoke-direct {v7, p0}, Lchat/ola/vn/activity/OlaLoginActivity$9$1;-><init>(Lchat/ola/vn/activity/OlaLoginActivity$9;)V

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

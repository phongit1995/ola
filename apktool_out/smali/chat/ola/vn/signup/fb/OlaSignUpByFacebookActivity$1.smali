.class Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->c(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity$1;->a:Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity$1;->a:Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->a(Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

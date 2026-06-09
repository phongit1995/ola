.class Lchat/ola/vn/activity/OlaUserProfileActivity$8;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->G()V
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x9

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->i(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/app/ProgressDialog;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    :cond_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    aget-object p1, p1, v0

    check-cast p1, Lchat/ola/vn/entity/ag;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v1, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Lchat/ola/vn/activity/OlaUserProfileActivity;Lchat/ola/vn/entity/ag;)Lchat/ola/vn/entity/ag;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->b:Ljava/lang/Integer;

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    :goto_0
    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Lchat/ola/vn/activity/OlaUserProfileActivity;Z)Z

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const/4 v0, 0x1

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->f(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$8;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->i(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/app/ProgressDialog;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V

    :cond_1
    return-void
.end method

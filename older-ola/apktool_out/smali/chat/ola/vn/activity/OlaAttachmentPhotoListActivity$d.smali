.class Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

.field private b:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->b:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->b:Landroid/view/LayoutInflater;

    const v1, 0x7f0b0136

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p2, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p2, v1, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Landroid/view/View;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v0

    goto :goto_0

    :catch_0
    move-exception p1

    move-object p2, v0

    goto :goto_1

    :catch_1
    move-exception p1

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {v0, v1, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Landroid/view/View;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    :cond_1
    :goto_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a(I)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$c;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_2
    if-nez p2, :cond_2

    return-object p3

    :cond_2
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->a(I)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    move-result-object p1

    return-object p1
.end method

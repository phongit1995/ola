.class Lchat/ola/vn/activity/OlaUserProfileActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/activity/OlaUserProfileActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaUserProfileActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->h(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const p3, 0x7f0f0552

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;

    move-result-object p2

    const/4 p3, 0x1

    iput-byte p3, p2, Lchat/ola/vn/entity/ag;->w:B

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const p3, 0x7f0f04ef

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;

    move-result-object p2

    const/4 p3, 0x0

    iput-byte p3, p2, Lchat/ola/vn/entity/ag;->w:B

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    const p3, 0x7f0f04f7

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;

    move-result-object p2

    const/4 p3, 0x2

    iput-byte p3, p2, Lchat/ola/vn/entity/ag;->w:B

    :cond_3
    :goto_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->h(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/TextView;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$7;->b:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->f(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

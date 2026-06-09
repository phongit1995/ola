.class Lchat/ola/vn/activity/OlaBottomTabActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaTabViewLayout$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaBottomTabActivity;->a(IIIILjava/lang/Class;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

.field final synthetic b:I

.field final synthetic c:I

.field final synthetic d:Lchat/ola/vn/activity/OlaBottomTabActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaBottomTabActivity;Lchat/ola/vn/activity/OlaBottomTabActivity$a;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->d:Lchat/ola/vn/activity/OlaBottomTabActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    iput p3, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->b:I

    iput p4, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->c:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a:Landroid/widget/ImageView;

    iget v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->b:I

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->c:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->H:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->a:Landroid/widget/ImageView;

    iget v0, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->c:I

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBottomTabActivity$2;->a:Lchat/ola/vn/activity/OlaBottomTabActivity$a;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaBottomTabActivity$a;->c:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->z:I

    goto :goto_0

    return-void
.end method

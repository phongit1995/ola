.class Lchat/ola/vn/signup/fb/d$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/d;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d$5;->a:Lchat/ola/vn/signup/fb/d;

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
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$5;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->b(Lchat/ola/vn/signup/fb/d;)Landroid/widget/EditText;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/signup/fb/d$5;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p2}, Lchat/ola/vn/signup/fb/d;->h(Lchat/ola/vn/signup/fb/d;)Ljava/util/List;

    move-result-object p2

    invoke-interface {p2, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/CharSequence;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

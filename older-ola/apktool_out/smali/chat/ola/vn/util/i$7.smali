.class final Lchat/ola/vn/util/i$7;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/entry/f;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/i;->b(Ljava/lang/String;)Ljava/lang/CharSequence;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 2

    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object v0

    invoke-virtual {v0, p3}, Lchat/ola/vn/util/g;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v0

    invoke-virtual {v0, p3}, Lchat/ola/vn/util/h;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p3

    sget v0, Lchat/ola/vn/f;->g:I

    const/4 v1, 0x0

    invoke-static {p1, p3, p2, v0, v1}, Lchat/ola/vn/util/i;->c(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p3

    sget v0, Lchat/ola/vn/f;->g:I

    invoke-static {p1, p3, p2, v0, v1}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p3

    sget v0, Lchat/ola/vn/f;->g:I

    invoke-static {p1, p3, p2, v0, v1}, Lchat/ola/vn/util/i;->d(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p3

    sget v0, Lchat/ola/vn/f;->g:I

    invoke-static {p1, p3, p2, v0, v1}, Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method

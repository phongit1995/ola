.class public Lchat/ola/vn/entry/b/k;
.super Lchat/ola/vn/entry/b/l;

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# instance fields
.field public a:Lcom/mg/ola/common/widget/OlaTextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    check-cast p1, Lcom/mg/ola/common/widget/OlaTextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    iget-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {p1, p0}, Lcom/mg/ola/common/widget/OlaTextView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 1

    iget-object p2, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/mg/ola/common/widget/OlaTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    iget p2, p0, Lchat/ola/vn/entry/b/k;->d:F

    const/4 v0, 0x2

    invoke-virtual {p1, v0, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setTextSize(IF)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    sget p2, Lchat/ola/vn/f;->g:I

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setBackgroundColor(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 3

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaTextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/k;->a:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->G:I

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setBackgroundColor(I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0491

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/entry/b/k$1;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/entry/b/k$1;-><init>(Lchat/ola/vn/entry/b/k;Ljava/util/List;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance p1, Lchat/ola/vn/entry/b/k$2;

    invoke-direct {p1, p0}, Lchat/ola/vn/entry/b/k$2;-><init>(Lchat/ola/vn/entry/b/k;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/i/m;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

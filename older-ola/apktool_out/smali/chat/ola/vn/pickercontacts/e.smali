.class public Lchat/ola/vn/pickercontacts/e;
.super Ljava/lang/Object;


# instance fields
.field protected a:Lchat/ola/vn/pickercontacts/c;

.field protected b:Landroid/view/View$OnClickListener;

.field protected c:Landroid/view/View$OnLongClickListener;

.field private d:Lchat/ola/vn/view/OlaCachedImageView;

.field private e:Landroid/view/View;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0x7f090255

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/e;->d:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090512

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/e;->f:Landroid/widget/TextView;

    const v0, 0x7f090579

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/e;->g:Landroid/widget/TextView;

    const v0, 0x7f090417

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/e;->e:Landroid/view/View;

    const v0, 0x7f090160

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/e;->h:Landroid/widget/ImageView;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->a:Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget-short v0, Lchat/ola/vn/pickercontacts/c;->b:S

    return v0
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/e;->b:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/e;->c:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/pickercontacts/c;)V
    .locals 4

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/pickercontacts/e;->a:Lchat/ola/vn/pickercontacts/c;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->g:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->d:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/c;->c()J

    move-result-wide v2

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/pickercontacts/g;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;J)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->e:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/e;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->e:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/e;->c:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->e:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/e;->h:Landroid/widget/ImageView;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/e;->h:Landroid/widget/ImageView;

    const v0, 0x7f080113

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/pickercontacts/e;->h:Landroid/widget/ImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f080115

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

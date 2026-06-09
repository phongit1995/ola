.class public Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/EditText;

.field private h:Landroid/widget/EditText;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method public static B()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->w()Ljava/util/List;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->f:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->g:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->h:Landroid/widget/EditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    sget-object v2, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    packed-switch v0, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iget-object v3, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->h:Landroid/widget/EditText;

    :goto_1
    invoke-virtual {v3, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :pswitch_1
    iget-object v3, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->g:Landroid/widget/EditText;

    goto :goto_1

    :pswitch_2
    iget-object v3, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->f:Landroid/widget/EditText;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->g:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->b(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_1
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0167

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->setContentView(I)V

    const p1, 0x7f0903f8

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->f:Landroid/widget/EditText;

    const p1, 0x7f0903f9

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->g:Landroid/widget/EditText;

    const p1, 0x7f0903fa

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->h:Landroid/widget/EditText;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f05ca

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method protected onStart()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->w()Ljava/util/List;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->e:Ljava/util/List;

    return-void
.end method

.class public Lchat/ola/vn/activity/OlaLoginActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/f/d;
.implements Lchat/ola/vn/network/a/a/p$a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "ClickableViewAccessibility"
    }
.end annotation


# instance fields
.field private A:Landroid/view/View;

.field private B:Ljava/lang/String;

.field private C:Lchat/ola/vn/network/a/a/p$a;

.field private D:Lchat/ola/vn/network/a/a/p$a;

.field private E:Lchat/ola/vn/network/a/a/ai$a;

.field private F:Lchat/ola/vn/network/c;

.field private G:Ljava/lang/Runnable;

.field private e:Landroid/widget/EditText;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/ImageView;

.field private h:Landroid/widget/EditText;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/view/View;

.field private k:Landroid/view/animation/Animation;

.field private l:Landroid/view/View;

.field private o:Lchat/ola/vn/view/OlaGalleryView;

.field private p:Lchat/ola/vn/b/t;

.field private q:Ljava/lang/String;

.field private r:I

.field private s:Landroid/view/View;

.field private t:Landroid/widget/Button;

.field private u:Landroid/view/View;

.field private v:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/h/a;",
            ">;"
        }
    .end annotation
.end field

.field private w:Landroid/view/View;

.field private x:Landroid/view/View;

.field private y:Landroid/view/View;

.field private z:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->q:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$1;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->F:Lchat/ola/vn/network/c;

    return-void
.end method

.method private F()V
    .locals 7

    const v0, 0x7f09030e

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->j:Landroid/view/View;

    const v0, 0x7f0900dd

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a7

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->l:Landroid/view/View;

    const v0, 0x7f090226

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->y:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->y:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->y:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900de

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->s:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->s:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->s:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f090112

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->u:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->u:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0900bd

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->w:Landroid/view/View;

    const v0, 0x7f0900bb

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->x:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->w:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->x:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905da

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    const v0, 0x7f0905d8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const v0, 0x7f0905d9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->g:Landroid/widget/ImageView;

    const v0, 0x7f0904f9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->i:Landroid/widget/TextView;

    const v0, 0x7f090007

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaGalleryView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaGalleryView;->setVisibility(I)V

    new-instance v0, Lchat/ola/vn/b/t;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/t;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/t;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaGalleryView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-static {p0}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaGalleryView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->l:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaGalleryView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->l:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-virtual {v0, v3}, Lchat/ola/vn/b/t;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    invoke-virtual {v0}, Lchat/ola/vn/b/t;->notifyDataSetChanged()V

    const v0, 0x7f0905a0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    const v0, 0x7f090576

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    new-instance v3, Lchat/ola/vn/activity/OlaLoginActivity$14;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaLoginActivity$14;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    new-instance v3, Lchat/ola/vn/activity/OlaLoginActivity$15;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaLoginActivity$15;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    new-instance v3, Lchat/ola/vn/activity/OlaLoginActivity$16;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaLoginActivity$16;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    if-eqz v3, :cond_4

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v3, :cond_4

    iget-object v5, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/h/a;

    if-eqz v5, :cond_2

    iget-object v6, v5, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v6, v6, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v0, v6}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    iget-object v3, v5, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object v3, v5, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/h/a;

    if-eqz v0, :cond_4

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    iget-object v4, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v4, v4, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object v0, v0, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-virtual {v3, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_4
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_4

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->x:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->x:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    :goto_5
    const v0, 0x7f0f0548

    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    const v3, 0x7f0f05dc

    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(I)V

    goto :goto_6

    :cond_7
    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    invoke-virtual {v2, v0}, Landroid/widget/Button;->setText(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_6

    :catch_0
    :try_start_3
    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    invoke-virtual {v2, v0}, Landroid/widget/Button;->setText(I)V

    :goto_6
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0905e0

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->z:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->z:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f0f068f

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ": "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_2
    return-void
.end method

.method private G()V
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->D()V

    return-void
.end method

.method private H()Lchat/ola/vn/network/a/a/p$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->C:Lchat/ola/vn/network/a/a/p$a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$7;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->C:Lchat/ola/vn/network/a/a/p$a;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->C:Lchat/ola/vn/network/a/a/p$a;

    return-object v0
.end method

.method private I()Lchat/ola/vn/network/a/a/p$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->D:Lchat/ola/vn/network/a/a/p$a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$8;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->D:Lchat/ola/vn/network/a/a/p$a;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->D:Lchat/ola/vn/network/a/a/p$a;

    return-object v0
.end method

.method private J()Lchat/ola/vn/network/a/a/ai$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->E:Lchat/ola/vn/network/a/a/ai$a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$9;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$9;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->E:Lchat/ola/vn/network/a/a/ai$a;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->E:Lchat/ola/vn/network/a/a/ai$a;

    return-object v0
.end method

.method private K()V
    .locals 5

    invoke-static {p0}, Lcom/mg/ola/common/d/g;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "1900588883"

    invoke-static {p0, v0}, Lchat/ola/vn/util/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    const v0, 0x7f0f00a2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f036c

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    const-string v4, "1900588883"

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    return-void
.end method

.method private L()V
    .locals 6

    new-instance v5, Lchat/ola/vn/activity/OlaLoginActivity$11;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaLoginActivity$11;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    const v1, 0x7f0f00a0

    const v2, 0x7f0f0099

    const v3, 0x7f0f0634

    const v4, 0x7f0f0480

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/network/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->F:Lchat/ola/vn/network/c;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->B:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/h/a;)V
    .locals 7

    const v0, 0x7f0f0280

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const v1, 0x7f0f0220

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f04a6

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0577

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/OlaLoginActivity$19;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity$19;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;Lchat/ola/vn/h/a;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9

    const-wide/16 v0, 0xbb8

    :try_start_0
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v2, p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Lchat/ola/vn/activity/OlaLoginActivity$17;

    move-object v3, v2

    move-object v4, p0

    move-object v5, p1

    move-object v6, p2

    move-object v7, p3

    move-object v8, p4

    invoke-direct/range {v3 .. v8}, Lchat/ola/vn/activity/OlaLoginActivity$17;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v2, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    new-instance v2, Lchat/ola/vn/activity/OlaLoginActivity$18;

    move-object v3, v2

    move-object v4, p0

    move-object v5, p1

    move-object v6, p2

    move-object v7, p3

    move-object v8, p4

    invoke-direct/range {v3 .. v8}, Lchat/ola/vn/activity/OlaLoginActivity$18;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v2, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;)Z
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    instance-of v0, v0, Lchat/ola/vn/activity/OlaLoginActivity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 p0, 0x0

    return p0

    :catch_0
    :cond_0
    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v1

    if-eqz v1, :cond_1

    const v1, 0x10008000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    goto :goto_0

    :cond_1
    const/high16 v1, 0x4000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    :goto_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :goto_1
    const/4 p0, 0x1

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->B:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    return-object p0
.end method

.method private c(Z)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->G:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$10;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$10;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->G:Ljava/lang/Runnable;

    :cond_0
    const-wide/32 v0, 0xea60

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v2}, Lchat/ola/vn/network/OlaNetworkService;->g()Z

    move-result v2

    if-eqz v2, :cond_1

    const-wide/16 v0, 0x3a98

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->G:Ljava/lang/Runnable;

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->j:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->G:Ljava/lang/Runnable;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/Button;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->t:Landroid/widget/Button;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "UnlocalizedSms"
        }
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    return-void

    :cond_0
    const v1, 0x7f0f00a0

    const v2, 0x7f0f0325

    const v3, 0x7f0f06c2

    const v4, 0x7f0f0577

    new-instance v5, Lchat/ola/vn/activity/OlaLoginActivity$6;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaLoginActivity$6;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->w:Landroid/view/View;

    return-object p0
.end method

.method static synthetic h(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->x:Landroid/view/View;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/view/OlaGalleryView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->o:Lchat/ola/vn/view/OlaGalleryView;

    return-object p0
.end method

.method static synthetic k(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->l:Landroid/view/View;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/b/t;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->p:Lchat/ola/vn/b/t;

    return-object p0
.end method

.method static synthetic m(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->K()V

    return-void
.end method

.method static synthetic n(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/network/a/a/ai$a;
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->J()Lchat/ola/vn/network/a/a/ai$a;

    move-result-object p0

    return-object p0
.end method

.method static synthetic o(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->j:Landroid/view/View;

    return-object p0
.end method


# virtual methods
.method public B()V
    .locals 9
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->isFocused()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    :goto_0
    invoke-static {p0, v1, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->isFocused()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->C()Z

    move-result v1

    if-eqz v1, :cond_7

    :try_start_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->w()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :cond_2
    const/4 v1, 0x1

    const/4 v2, 0x0

    :try_start_2
    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_5

    :try_start_3
    iget-object v4, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_4

    :try_start_4
    iget-object v5, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getVisibility()I

    move-result v5

    if-nez v5, :cond_3

    iget-object v5, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v5}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :try_start_5
    invoke-static {v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_2

    :cond_3
    move-object v6, v2

    :goto_2
    move-object v5, v6

    goto :goto_3

    :catch_2
    move-object v5, v2

    :catch_3
    :goto_3
    :try_start_6
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    iget-object v6, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    if-eqz v6, :cond_5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaLoginActivity;->v:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_4
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lchat/ola/vn/h/a;

    iget-object v8, v7, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v8, v8, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v8, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    iget-object v6, v7, Lchat/ola/vn/h/a;->d:Ljava/lang/String;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_6

    move-object v2, v6

    goto :goto_5

    :catch_4
    move-object v4, v2

    goto :goto_4

    :catch_5
    move-object v3, v2

    move-object v4, v3

    :goto_4
    move-object v5, v4

    :catch_6
    :cond_5
    :goto_5
    :try_start_7
    iget-object v6, p0, Lchat/ola/vn/activity/OlaLoginActivity;->q:Ljava/lang/String;

    invoke-static {v6, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_6

    iput-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->q:Ljava/lang/String;

    :goto_6
    iput v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    goto :goto_7

    :cond_6
    iget v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_7

    add-int/2addr v0, v1

    goto :goto_6

    :catch_7
    :goto_7
    invoke-direct {p0, v3, v4, v5, v2}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_7
    return-void
.end method

.method public C()Z
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "DefaultLocale"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_0
    return v0

    :cond_1
    const-string v3, "@"

    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    if-lez v3, :cond_2

    invoke-virtual {v1, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v3, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    const/4 v3, 0x1

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/CharSequence;I)Z

    move-result v1

    if-nez v1, :cond_3

    const v1, 0x7f0f00a7

    const v2, 0x7f0f0287

    invoke-static {p0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return v0

    :cond_3
    invoke-static {v2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_4
    return v0

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getVisibility()I

    move-result v1

    if-nez v1, :cond_7

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_6
    return v0

    :cond_7
    return v3

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    return v0
.end method

.method public D()V
    .locals 4

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    sget-object v3, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    invoke-direct {v1, v2, v3}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;-><init>(Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReadPhoneStateEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReceiveSMS(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setFacebookNotificationsEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity;->ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->build()Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x4

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method public E()V
    .locals 4

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/facebook/accountkit/ui/AccountKitActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/LoginType;->PHONE:Lcom/facebook/accountkit/ui/LoginType;

    sget-object v3, Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;->TOKEN:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    invoke-direct {v1, v2, v3}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;-><init>(Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReadPhoneStateEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setReceiveSMS(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    invoke-virtual {v1, v2}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->setFacebookNotificationsEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;

    sget-object v2, Lcom/facebook/accountkit/ui/AccountKitActivity;->ACCOUNT_KIT_ACTIVITY_CONFIGURATION:Ljava/lang/String;

    invoke-virtual {v1}, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->build()Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x6

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method protected a()V
    .locals 2

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->h()I

    move-result v0

    sput v0, Lchat/ola/vn/h;->q:I

    sget v0, Lchat/ola/vn/h;->q:I

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;ILandroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->finish()V

    :cond_0
    return-void
.end method

.method public a(ILjava/lang/String;[B)V
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object v1, v0

    :goto_0
    if-eqz p1, :cond_a

    const/4 v2, 0x2

    if-eq p1, v2, :cond_7

    const/4 p2, 0x7

    const/4 v2, 0x3

    if-eq p1, p2, :cond_3

    const/16 p2, 0xa

    if-eq p1, p2, :cond_0

    goto/16 :goto_3

    :cond_0
    :try_start_1
    iget p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    if-lt p1, v2, :cond_1

    iput v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_c

    :goto_1
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->f(Ljava/lang/String;)V

    goto/16 :goto_3

    :cond_1
    const p1, 0x7f0f01f7

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    goto/16 :goto_3

    :cond_3
    iget p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    if-lt p1, v2, :cond_4

    iput v2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->r:I

    goto :goto_1

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_6
    const p1, 0x7f0f01f8

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V

    goto :goto_3

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-nez p1, :cond_c

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->i:Landroid/widget/TextView;

    const p2, 0x7f0f05ec

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_9
    const p1, 0x7f0f06c0

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V

    goto :goto_3

    :cond_a
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_b

    const p1, 0x7f0f0263

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    :cond_b
    move-object v3, p2

    const p1, 0x7f0f009f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const p1, 0x7f0f002c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const p1, 0x7f0f0480

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/OlaLoginActivity$5;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaLoginActivity$5;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    :cond_c
    :goto_3
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    if-eqz p3, :cond_d

    array-length p2, p3

    invoke-static {p3, p1, p2}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p3, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->g:Landroid/widget/ImageView;

    invoke-virtual {p3, p2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_d
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->g:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 7

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    const/16 v1, 0x3b

    if-ne p5, v1, :cond_0

    const/4 v1, 0x7

    if-eq p1, v1, :cond_0

    const/16 v1, 0xa

    if-eq p1, v1, :cond_0

    const/16 v1, 0x17

    if-eq p1, v1, :cond_0

    const/16 v1, 0x29

    if-eq p1, v1, :cond_0

    packed-switch p1, :pswitch_data_0

    const v1, 0x7f0f009f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f0f02a8

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ": "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const v0, 0x7f0f002c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f0480

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaLoginActivity$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaLoginActivity$4;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->c(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/d;

    return-void

    :pswitch_0
    const v1, 0x7f0f009f

    const v2, 0x7f0f01fc

    const v3, 0x7f0f002c

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/activity/OlaLoginActivity$3;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaLoginActivity$3;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :cond_0
    :pswitch_1
    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/lang/String;[B)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p2, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const v2, 0x7f0f05ec

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    array-length p1, p2

    invoke-static {p2, v0, p1}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->g:Landroid/widget/ImageView;

    invoke-virtual {p2, p1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_1
    invoke-static {p0, v2}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->h:Landroid/widget/EditText;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->g:Landroid/widget/ImageView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->A:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public o()V
    .locals 0

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 3

    const/4 v0, 0x4

    if-ne p1, v0, :cond_4

    :try_start_0
    const-string p1, "account_kit_log_in_result"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/AccountKitLoginResult;

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p2

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->wasCancelled()Z

    move-result p2

    if-eqz p2, :cond_1

    return-void

    :cond_1
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p2

    if-eqz p2, :cond_3

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez p2, :cond_2

    :try_start_1
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->I()Lchat/ola/vn/network/a/a/p$a;

    move-result-object p3

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/p$a;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    return-void

    :cond_3
    :goto_0
    :try_start_2
    invoke-static {p0}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Lchat/ola/vn/c;)V

    return-void

    :cond_4
    const/4 v0, 0x6

    const/4 v1, 0x1

    if-ne p1, v0, :cond_8

    const-string p1, "account_kit_log_in_result"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/AccountKitLoginResult;

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object p2

    if-eqz p2, :cond_5

    return-void

    :cond_5
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->wasCancelled()Z

    move-result p2

    if-eqz p2, :cond_6

    return-void

    :cond_6
    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p2

    if-eqz p2, :cond_a

    invoke-interface {p1}, Lcom/facebook/accountkit/AccountKitLoginResult;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/accountkit/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_7

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->H()Lchat/ola/vn/network/a/a/p$a;

    move-result-object p3

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/p$a;)V

    :cond_7
    return-void

    :cond_8
    const/4 v0, 0x7

    const/4 v2, -0x1

    if-ne p1, v0, :cond_9

    if-ne p2, v2, :cond_a

    const-string p1, "_username"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "_pass"

    invoke-virtual {p3, p2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p3, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    :goto_1
    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->B()V

    return-void

    :cond_9
    if-ne p2, v2, :cond_a

    if-ne p1, v1, :cond_a

    const-string p1, "_username"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "_pass"

    invoke-virtual {p3, p2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p3, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    :cond_a
    return-void
.end method

.method public onBackPressed()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->finish()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x1

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/h/a;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    iget-object v1, p1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v1, v1, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    iget-object v1, p1, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p1, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object p1, p1, Lchat/ola/vn/h/a;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->B()V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/h/a;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/h/a;)V

    return-void

    :sswitch_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->L()V

    return-void

    :sswitch_3
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->G()V

    return-void

    :sswitch_4
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->F:Lchat/ola/vn/network/c;

    invoke-static {p1, v0}, Lchat/ola/vn/l/b;->a(Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void

    :cond_0
    const/4 p1, 0x0

    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$2;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Landroid/content/Context;Landroid/os/Bundle;Lchat/ola/vn/activity/OlaFacebookActivity$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-void

    :sswitch_5
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->G()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->B()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->B()V

    return-void

    :sswitch_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->e:Landroid/widget/EditText;

    :goto_0
    invoke-static {p0, p1, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return-void

    :sswitch_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity;->f:Landroid/widget/EditText;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    :cond_2
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0900bb -> :sswitch_7
        0x7f0900bd -> :sswitch_6
        0x7f0900dd -> :sswitch_5
        0x7f0900de -> :sswitch_4
        0x7f090112 -> :sswitch_3
        0x7f090226 -> :sswitch_2
        0x7f09025a -> :sswitch_1
        0x7f09027c -> :sswitch_0
        0x7f0904e6 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->b()I

    move-result p1

    if-lez p1, :cond_0

    const/16 v0, 0x58

    if-gt p1, v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h/b;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->m()Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {}, Ljava/util/Locale;->getAvailableLocales()[Ljava/util/Locale;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_3

    array-length v2, v0

    if-lez v2, :cond_3

    array-length v2, v0

    sub-int/2addr v2, v1

    :goto_0
    if-ltz v2, :cond_3

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x5f

    invoke-virtual {v3, v4}, Ljava/lang/String;->indexOf(I)I

    move-result v4

    if-lez v4, :cond_1

    const-string v4, "_"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    aget-object v3, v3, p1

    :cond_1
    const-string v4, "vi"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v0, "default"

    invoke-static {v0}, Lchat/ola/vn/c/x;->b(Ljava/lang/String;)V

    const/4 v1, 0x0

    goto :goto_1

    :cond_2
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    :cond_3
    :goto_1
    if-eqz v1, :cond_4

    invoke-static {p0}, Lchat/ola/vn/activity/OlaLanguageChooser;->a(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->finish()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception v0

    const-string v1, "default"

    invoke-static {v1}, Lchat/ola/vn/c/x;->b(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    :try_start_2
    invoke-virtual {p0, p1, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->overridePendingTransition(II)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    const p1, 0x7f0b00d3

    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->setContentView(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_4

    const v0, 0x7f0903a6

    :try_start_4
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaLoginActivity$12;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaLoginActivity$12;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    const v0, 0x7f010042

    :try_start_5
    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity;->k:Landroid/view/animation/Animation;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->F()V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-static {p0, v0}, Lbolts/c;->a(Landroid/content/Context;Landroid/content/Intent;)Landroid/net/Uri;

    move-result-object v0
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    if-eqz v0, :cond_5

    :try_start_6
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    const-string v0, "Launch From AppLink"

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/f;->c(Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    return-void

    :cond_5
    :try_start_7
    new-instance v0, Lchat/ola/vn/activity/OlaLoginActivity$13;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaLoginActivity$13;-><init>(Lchat/ola/vn/activity/OlaLoginActivity;)V

    invoke-static {p0, v0}, Lcom/facebook/applinks/AppLinkData;->fetchDeferredAppLinkData(Landroid/content/Context;Lcom/facebook/applinks/AppLinkData$CompletionHandler;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    return-void

    :catch_4
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :try_start_8
    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->F()V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_5

    :catch_5
    return-void
.end method

.method public q()V
    .locals 0

    return-void
.end method

.method public s()V
    .locals 0

    return-void
.end method

.method public t()V
    .locals 0

    return-void
.end method

.method public w()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Z)V

    const-class v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Ljava/lang/Class;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->finish()V

    return-void
.end method
